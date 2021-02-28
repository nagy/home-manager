{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.amfora;

  tomlFormat = pkgs.formats.toml { };

in {
  meta.maintainers = [ ];

  options.programs.amfora = {
    enable = mkEnableOption "amfora, gemini client";

    settings = mkOption {
      type = tomlFormat.type;
      default = { };
      description = ''
        Configuration written to
        <filename>~/.config/amfora/config.toml</filename>.
        </para><para>
      '';
    };

  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.amfora ];

    xdg.configFile."amfora/config.toml" = mkIf (cfg.settings != { }) {
      source = tomlFormat.generate "amfora-config.toml" cfg.settings;
    };

  };
}
