The support directory is not autoloaded by default. 
To enable this, open the rails helper and comment out the support directory auto-loading and then include it as shared module for all request specs in the RSpec configuration block.
