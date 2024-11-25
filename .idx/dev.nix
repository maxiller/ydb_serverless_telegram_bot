# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.bash-completion
    pkgs.zip

  ];

  # Sets environment variables in the workspace
  env = {
    PATH = ["/home/user/bin"];
    YC_TOKEN = "";
    TF_VAR_YC_FOLDER_NAME = "aishitalk";
    TF_VAR_YC_FOLDER_DESCRIPTION = "Test YDB serverless telegram bot example";
    TF_VAR_TELEGRAM_BOT_API_KEY = "";
    TF_VAR_TELEGRAM_API_ID = "";
    TF_VAR_TELEGRAM_API_HASH = "";
    TF_VAR_TELEGRAM_CLIENT_SESSION = "";
    TF_VAR_YC_CLOUD_ID = "";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
      "ms-python.python"
      "ms-python.debugpy"
      "hashicorp.terraform"
      "mhutchie.git-graph"
    ];

    # Enable previews
    previews = {
      enable = true;
    };

    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        yc-install = "curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -a";
      };
      # Runs when the workspace is (re)started
      onStart = {
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";
      };
    };
  };
}
