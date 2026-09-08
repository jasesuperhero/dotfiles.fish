function pubkey -d "copy your SSH public key to the clipboard"
    # Prefer ed25519 (the modern default), fall back to rsa.
    set -l key ~/.ssh/id_ed25519.pub
    test -f $key; or set key ~/.ssh/id_rsa.pub
    if not test -f $key
        echo (set_color red)"no ~/.ssh/id_ed25519.pub or id_rsa.pub found"(set_color normal) >&2
        return 1
    end
    if not command -q pbcopy
        echo (set_color red)"pbcopy not found (this helper is macOS-only)"(set_color normal) >&2
        return 1
    end
    pbcopy <$key
    echo (set_color brblue)"-> "(path basename $key)" copied to clipboard"(set_color normal)
end
