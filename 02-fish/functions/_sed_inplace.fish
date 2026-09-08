function _sed_inplace -d "portable in-place sed (BSD/macOS and GNU/Linux)"
    # BSD sed (macOS) requires an explicit empty backup-suffix arg (`-i ''`),
    # while GNU sed (Linux) treats that '' as the script. Branch on which sed
    # this is so theme scripts work on both platforms.
    if sed --version >/dev/null 2>&1
        sed -i $argv
    else
        sed -i '' $argv
    end
end
