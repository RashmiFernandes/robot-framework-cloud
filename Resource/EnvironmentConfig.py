import json
import os
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

class EnvironmentConfig:
    """
    Library to load environment-specific configuration
    """
    
    def __init__(self):
        self.config = {}
        self.current_env = None
    
    @keyword
    def load_environment_config(self, environment="A"):
        """
        Load configuration for the specified environment
        
        Args:
            environment: Environment identifier (A, B, C)
        """
        self.current_env = environment
        config_file = f"config/environment_{environment}.json"
        
        # Check if file exists
        if not os.path.exists(config_file):
            raise FileNotFoundError(f"Configuration file not found: {config_file}")
        
        try:
            with open(config_file, 'r') as f:
                self.config = json.load(f)
            
            # Set global variables in Robot Framework
            builtin = BuiltIn()
            
            # Set URL variables
            builtin.set_global_variable("${OGFURL}", self.config.get("OGF_URL", ""))
            builtin.set_global_variable("${OGF_URL}", self.config.get("OGF_URL", ""))
            builtin.set_global_variable("${OGWURL}", self.config.get("OGW_URL", ""))
            builtin.set_global_variable("${OGW_URL}", self.config.get("OGW_URL", ""))
            builtin.set_global_variable("${HTMLURL}", self.config.get("HTML_URL", ""))
            builtin.set_global_variable("${HTML_URL}", self.config.get("HTML_URL", ""))
            builtin.set_global_variable("${OGSCOUTURL}", self.config.get("OGSCOUT_URL", ""))
            builtin.set_global_variable("${PSCOUTURL}", self.config.get("OGSCOUT_URL", ""))
            builtin.set_global_variable("${OGAPPCONFIG_URL}", self.config.get("APPCONFIG_URL", ""))
            builtin.set_global_variable("${IncidentMgr_URL}", self.config.get("INCIDENT_MGR_URL", ""))
            builtin.set_global_variable("${BASEURL}", self.config.get("BASE_URL", ""))
            builtin.set_global_variable("${ENVSERVER}", self.config.get("ENV_SERVER", ""))
            
            # Set user variables
            users = self.config.get("USERS", {})
            builtin.set_global_variable("${OGFUSER}", users.get("OGF_USER", ""))
            builtin.set_global_variable("${OGF_USER}", users.get("OGF_USER", ""))
            builtin.set_global_variable("${OGWUSER}", users.get("OGW_USER", ""))
            builtin.set_global_variable("${OGW_USER}", users.get("OGW_USER", ""))
            builtin.set_global_variable("${HTMLUSER}", users.get("HTML_USER", ""))
            builtin.set_global_variable("${HTML_USER}", users.get("HTML_USER", ""))
            builtin.set_global_variable("${OGSCOUTUSER}", users.get("OGSCOUT_USER", ""))
            builtin.set_global_variable("${PSCOUTUSER}", users.get("OGSCOUT_USER", ""))
            builtin.set_global_variable("${IncMgr_USER}", users.get("INCIDENT_MGR_USER", ""))
            builtin.set_global_variable("${APPCONFIG_USER}", users.get("APPCONFIG_USER", ""))
            
            # Set password variables
            passwords = self.config.get("PASSWORDS", {})
            builtin.set_global_variable("${OGF_PWD}", passwords.get("OGF_PWD", "test"))
            builtin.set_global_variable("${OGW_PWD}", passwords.get("OGW_PWD", "test"))
            builtin.set_global_variable("${HTMLPWD}", passwords.get("HTML_PWD", "test"))
            builtin.set_global_variable("${HTML_PWD}", passwords.get("HTML_PWD", "test"))
            builtin.set_global_variable("${PSCOUTPWD}", passwords.get("OGSCOUT_PWD", "test"))
            builtin.set_global_variable("${IncMgr_PWD}", passwords.get("INCIDENT_MGR_PWD", "test"))
            builtin.set_global_variable("${APPCONFIG_PWD}", passwords.get("APPCONFIG_PWD", "test"))
            
            # Set test data variables
            test_data = self.config.get("TEST_DATA", {})
            for key, value in test_data.items():
                builtin.set_global_variable(f"${{{key}}}", value)
            
            # Set alias variables
            aliases = self.config.get("ALIASES", {})
            for key, value in aliases.items():
                builtin.set_global_variable(f"${{{key}}}", value)
            
            # Set HTML app variables
            html_apps = self.config.get("HTML_APPS", {})
            for key, value in html_apps.items():
                builtin.set_global_variable(f"${{{key}}}", value)
            
            # Set database configuration
            db_config = self.config.get("DB_CONFIG", {})
            builtin.set_global_variable("${DB_HOST}", db_config.get("host", ""))
            builtin.set_global_variable("${DB_Host}", db_config.get("host", ""))
            builtin.set_global_variable("${DB_PORT}", str(db_config.get("port", "")))
            builtin.set_global_variable("${DB_Port}", str(db_config.get("port", "")))
            builtin.set_global_variable("${DB_NAME}", db_config.get("database", ""))
            builtin.set_global_variable("${DB_Name}", db_config.get("database", ""))
            builtin.set_global_variable("${DB_USER}", db_config.get("username", ""))
            builtin.set_global_variable("${DB_PASSWORD}", db_config.get("password", ""))
            builtin.set_global_variable("${DBConnect}", db_config.get("connection_string", ""))
            
            # Set environment name
            builtin.set_global_variable("${ENV}", self.config.get("env_name", environment))
            
            return f"Successfully loaded configuration for environment {environment} ({self.config.get('env_name', 'Unknown')})"
            
        except json.JSONDecodeError as e:
            raise ValueError(f"Invalid JSON in configuration file: {e}")
        except Exception as e:
            raise RuntimeError(f"Error loading configuration: {e}")
    
    @keyword
    def get_config_value(self, key_path):
        """
        Get a specific configuration value using dot notation
        
        Args:
            key_path: Path to the configuration value (e.g., "DB_CONFIG.host")
        """
        if not self.config:
            raise RuntimeError("No configuration loaded. Call 'Load Environment Config' first.")
        
        keys = key_path.split('.')
        value = self.config
        
        try:
            for key in keys:
                value = value[key]
            return value
        except (KeyError, TypeError):
            raise KeyError(f"Configuration key not found: {key_path}")
    
    @keyword
    def get_current_environment(self):
        """
        Get the currently loaded environment
        """
        return self.current_env if self.current_env else "None"
    
    @keyword
    def set_browser_options_for_environment(self):
        """
        Set browser options based on environment (headless for cloud)
        """
        builtin = BuiltIn()
        
        # Check if running in Docker/Cloud (headless mode)
        headless = os.getenv('HEADLESS', 'false').lower() == 'true'
        
        if headless:
            chrome_options = [
                '--headless',
                '--no-sandbox',
                '--disable-dev-shm-usage',
                '--disable-gpu',
                '--window-size=1920,1080'
            ]
            builtin.set_global_variable("${CHROME_OPTIONS}", chrome_options)
        else:
            builtin.set_global_variable("${CHROME_OPTIONS}", [])
        
        return f"Browser configured for {'headless' if headless else 'headed'} mode"