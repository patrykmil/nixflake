{
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    theme = {
      colourful = true;

      filekinds = {
        normal = {
          foreground = "#E4F0FB";
        };
        directory = {
          foreground = "#ADD7FF";
        };
        symlink = {
          foreground = "#89DDFF";
        };
        pipe = {
          foreground = "#767C9D";
        };
        block_device = {
          foreground = "#D0679D";
        };
        char_device = {
          foreground = "#D0679D";
        };
        socket = {
          foreground = "#506477";
        };
        special = {
          foreground = "#FCC5E9";
        };
        executable = {
          foreground = "#5DE4C7";
        };
        mount_point = {
          foreground = "#91B4D5";
        };
      };

      perms = {
        user_read = {
          foreground = "#E4F0FB";
        };
        user_write = {
          foreground = "#FFFAC2";
        };
        user_execute_file = {
          foreground = "#5DE4C7";
        };
        user_execute_other = {
          foreground = "#5DE4C7";
        };
        group_read = {
          foreground = "#A6ACCD";
        };
        group_write = {
          foreground = "#FFFAC2";
        };
        group_execute = {
          foreground = "#5DE4C7";
        };
        other_read = {
          foreground = "#767C9D";
        };
        other_write = {
          foreground = "#FFFAC2";
        };
        other_execute = {
          foreground = "#5DE4C7";
        };
        special_user_file = {
          foreground = "#FCC5E9";
        };
        special_other = {
          foreground = "#506477";
        };
        attribute = {
          foreground = "#767C9D";
        };
      };

      size = {
        major = {
          foreground = "#767C9D";
        };
        minor = {
          foreground = "#89DDFF";
        };
        number_byte = {
          foreground = "#E4F0FB";
        };
        number_kilo = {
          foreground = "#A6ACCD";
        };
        number_mega = {
          foreground = "#ADD7FF";
        };
        number_giga = {
          foreground = "#FCC5E9";
        };
        number_huge = {
          foreground = "#FCC5E9";
        };
        unit_byte = {
          foreground = "#767C9D";
        };
        unit_kilo = {
          foreground = "#ADD7FF";
        };
        unit_mega = {
          foreground = "#FCC5E9";
        };
        unit_giga = {
          foreground = "#FCC5E9";
        };
        unit_huge = {
          foreground = "#91B4D5";
        };
      };

      users = {
        user_you = {
          foreground = "#E4F0FB";
        };
        user_root = {
          foreground = "#D0679D";
        };
        user_other = {
          foreground = "#FCC5E9";
        };
        group_yours = {
          foreground = "#A6ACCD";
        };
        group_other = {
          foreground = "#767C9D";
        };
        group_root = {
          foreground = "#D0679D";
        };
      };

      links = {
        normal = {
          foreground = "#89DDFF";
        };
        multi_link_file = {
          foreground = "#91B4D5";
        };
      };

      git = {
        new = {
          foreground = "#5DE4C7";
        };
        modified = {
          foreground = "#FFFAC2";
        };
        deleted = {
          foreground = "#D0679D";
        };
        renamed = {
          foreground = "#5FB3A1";
        };
        typechange = {
          foreground = "#FAE4FC";
        };
        ignored = {
          foreground = "#767C9D";
        };
        conflicted = {
          foreground = "#D0679D";
        };
      };

      git_repo = {
        branch_main = {
          foreground = "#E4F0FB";
        };
        branch_other = {
          foreground = "#FCC5E9";
        };
        git_clean = {
          foreground = "#5DE4C7";
        };
        git_dirty = {
          foreground = "#D0679D";
        };
      };

      security_context = {
        colon = {
          foreground = "#767C9D";
        };
        user = {
          foreground = "#A6ACCD";
        };
        role = {
          foreground = "#FCC5E9";
        };
        typ = {
          foreground = "#506477";
        };
        range = {
          foreground = "#FCC5E9";
        };
      };

      file_type = {
        image = {
          foreground = "#FFFAC2";
        };
        video = {
          foreground = "#D0679D";
        };
        music = {
          foreground = "#5DE4C7";
        };
        lossless = {
          foreground = "#5FB3A1";
        };
        crypto = {
          foreground = "#506477";
        };
        document = {
          foreground = "#E4F0FB";
        };
        compressed = {
          foreground = "#FAE4FC";
        };
        temp = {
          foreground = "#D0679D";
        };
        compiled = {
          foreground = "#91B4D5";
        };
        build = {
          foreground = "#506477";
        };
        source = {
          foreground = "#ADD7FF";
        };
      };

      punctuation = {
        foreground = "#767C9D";
      };
      date = {
        foreground = "#FFFAC2";
      };
      inode = {
        foreground = "#767C9D";
      };
      blocks = {
        foreground = "#A6ACCD";
      };
      header = {
        foreground = "#E4F0FB";
      };
      octal = {
        foreground = "#5FB3A1";
      };
      flags = {
        foreground = "#FCC5E9";
      };

      symlink_path = {
        foreground = "#89DDFF";
      };
      control_char = {
        foreground = "#91B4D5";
      };
      broken_symlink = {
        foreground = "#D0679D";
      };
      broken_path_overlay = {
        foreground = "#506477";
      };
    };
  };
}
