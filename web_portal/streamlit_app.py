import streamlit as st
import requests
import json
import os
import time
from datetime import datetime
import base64

# Page configuration
st.set_page_config(
    page_title="Robot Framework Cloud Test Runner",
    page_icon="🤖",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Custom CSS
st.markdown("""
<style>
    .main-header {
        text-align: center;
        padding: 2rem 0;
        background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 10px;
        margin-bottom: 2rem;
    }
    .status-card {
        padding: 1rem;
        border-radius: 8px;
        margin: 1rem 0;
        border-left: 4px solid;
    }
    .success { border-left-color: #28a745; background-color: #d4edda; }
    .failure { border-left-color: #dc3545; background-color: #f8d7da; }
    .running { border-left-color: #ffc107; background-color: #fff3cd; }
    .info { border-left-color: #17a2b8; background-color: #d1ecf1; }
</style>
""", unsafe_allow_html=True)

class GitHubAPI:
    def __init__(self, token, owner, repo):
        self.token = token
        self.owner = owner
        self.repo = repo
        self.headers = {
            "Authorization": f"token {token}",
            "Accept": "application/vnd.github.v3+json"
        }
        self.base_url = f"https://api.github.com/repos/{owner}/{repo}"
    
    def trigger_workflow(self, environment, test_suite, browser, parallel=False):
        """Trigger the GitHub Actions workflow"""
        url = f"{self.base_url}/actions/workflows/robot-tests.yml/dispatches"
        payload = {
            "ref": "main",
            "inputs": {
                "environment": environment,
                "test_suite": test_suite,
                "browser": browser,
                "parallel": str(parallel).lower()
            }
        }
        
        response = requests.post(url, headers=self.headers, json=payload)
        return response.status_code == 204
    
    def get_workflow_runs(self, limit=10):
        """Get recent workflow runs"""
        url = f"{self.base_url}/actions/workflows/robot-tests.yml/runs"
        params = {"per_page": limit}
        
        response = requests.get(url, headers=self.headers, params=params)
        if response.status_code == 200:
            return response.json()["workflow_runs"]
        return []
    
    def get_run_artifacts(self, run_id):
        """Get artifacts for a specific run"""
        url = f"{self.base_url}/actions/runs/{run_id}/artifacts"
        
        response = requests.get(url, headers=self.headers)
        if response.status_code == 200:
            return response.json()["artifacts"]
        return []

def main():
    # Header
    st.markdown("""
    <div class="main-header">
        <h1>🤖 Robot Framework Cloud Test Runner</h1>
        <p>Execute your Robot Framework tests in the cloud with environment selection</p>
    </div>
    """, unsafe_allow_html=True)
    
    # Sidebar configuration
    st.sidebar.header("⚙️ Configuration")
    
    # GitHub configuration
    github_token = st.sidebar.text_input("GitHub Token", type="password", help="Personal Access Token with repo and actions permissions")
    github_owner = st.sidebar.text_input("GitHub Owner", value="your-username", help="GitHub username or organization")
    github_repo = st.sidebar.text_input("Repository Name", value="Robot_OnCloud_Docker", help="Repository name")
    
    if not all([github_token, github_owner, github_repo]):
        st.warning("⚠️ Please configure GitHub settings in the sidebar")
        st.info("""
        **Setup Instructions:**
        1. Go to GitHub Settings → Developer settings → Personal access tokens
        2. Generate a new token with `repo` and `actions` permissions
        3. Enter your GitHub username and repository name
        4. Paste the token in the sidebar
        """)
        return
    
    github_api = GitHubAPI(github_token, github_owner, github_repo)
    
    # Main content area
    col1, col2 = st.columns([2, 1])
    
    with col1:
        st.header("🚀 Run Tests")
        
        # Test configuration
        with st.form("test_config"):
            col_env, col_suite = st.columns(2)
            
            with col_env:
                environment = st.selectbox(
                    "🌍 Environment",
                    options=["A", "B", "C"],
                    help="Select the target environment"
                )
            
            with col_suite:
                test_suite = st.selectbox(
                    "📋 Test Suite",
                    options=["Sanity", "All"],
                    help="Choose which tests to run"
                )
            
            col_browser, col_parallel = st.columns(2)
            
            with col_browser:
                browser = st.selectbox(
                    "🌐 Browser",
                    options=["chrome", "firefox", "edge"],
                    help="Browser for test execution"
                )
            
            with col_parallel:
                parallel = st.checkbox(
                    "⚡ Parallel Execution",
                    help="Run tests in parallel for faster execution"
                )
            
            submit_button = st.form_submit_button("🚀 Start Tests", use_container_width=True)
            
            if submit_button:
                with st.spinner("🔄 Triggering test execution..."):
                    success = github_api.trigger_workflow(environment, test_suite, browser, parallel)
                    
                    if success:
                        st.success(f"✅ Tests triggered successfully for Environment {environment}!")
                        st.info("🔗 Check the 'Recent Runs' section below for status updates")
                    else:
                        st.error("❌ Failed to trigger tests. Check your GitHub configuration.")
    
    with col2:
        st.header("📊 Environment Status")
        
        # Environment health check (placeholder)
        environments = {
            "A": {"status": "healthy", "last_check": "2 min ago"},
            "B": {"status": "warning", "last_check": "5 min ago"},
            "C": {"status": "healthy", "last_check": "1 min ago"}
        }
        
        for env, info in environments.items():
            status_class = "success" if info["status"] == "healthy" else "failure" if info["status"] == "error" else "running"
            status_icon = "🟢" if info["status"] == "healthy" else "🟡" if info["status"] == "warning" else "🔴"
            
            st.markdown(f"""
            <div class="status-card {status_class}">
                <strong>{status_icon} Environment {env}</strong><br>
                Status: {info["status"].title()}<br>
                Last Check: {info["last_check"]}
            </div>
            """, unsafe_allow_html=True)
    
    # Recent workflow runs
    st.header("📈 Recent Test Runs")
    
    if st.button("🔄 Refresh Status"):
        st.rerun()
    
    try:
        workflow_runs = github_api.get_workflow_runs(limit=10)
        
        if workflow_runs:
            for run in workflow_runs:
                created_at = datetime.fromisoformat(run["created_at"].replace("Z", "+00:00"))
                
                # Status styling
                status = run["status"]
                conclusion = run.get("conclusion")
                
                if status == "completed":
                    if conclusion == "success":
                        status_display = "✅ Success"
                        status_class = "success"
                    elif conclusion == "failure":
                        status_display = "❌ Failed"
                        status_class = "failure"
                    else:
                        status_display = f"⚪ {conclusion.title()}"
                        status_class = "info"
                elif status == "in_progress":
                    status_display = "🔄 Running"
                    status_class = "running"
                else:
                    status_display = f"⏳ {status.title()}"
                    status_class = "info"
                
                # Extract environment from commit message or inputs
                env_info = "Unknown"
                if run.get("head_commit") and run["head_commit"].get("message"):
                    message = run["head_commit"]["message"]
                    if "Environment" in message:
                        env_info = message.split("Environment")[1].split()[0]
                
                with st.expander(f"{status_display} - Run #{run['run_number']} - {created_at.strftime('%Y-%m-%d %H:%M')}"):
                    col1, col2, col3 = st.columns(3)
                    
                    with col1:
                        st.write(f"**Environment:** {env_info}")
                        st.write(f"**Branch:** {run['head_branch']}")
                    
                    with col2:
                        st.write(f"**Status:** {status_display}")
                        st.write(f"**Duration:** {run.get('updated_at', 'N/A')}")
                    
                    with col3:
                        st.link_button("🔗 View on GitHub", run["html_url"])
                        
                        if status == "completed":
                            # Get artifacts
                            artifacts = github_api.get_run_artifacts(run["id"])
                            if artifacts:
                                st.write("📄 **Artifacts:**")
                                for artifact in artifacts:
                                    st.write(f"• {artifact['name']}")
        else:
            st.info("No recent workflow runs found.")
            
    except Exception as e:
        st.error(f"Error fetching workflow runs: {str(e)}")
    
    # Footer
    st.markdown("---")
    st.markdown("""
    <div style="text-align: center; color: #666;">
        <p>🤖 Robot Framework Cloud Test Runner | Built with Streamlit</p>
    </div>
    """, unsafe_allow_html=True)

if __name__ == "__main__":
    main()