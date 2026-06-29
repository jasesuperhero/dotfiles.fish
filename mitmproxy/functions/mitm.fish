function __mitm_service -d "Highest-priority enabled network service that has an IPv4 address"
    # Service names appear in priority order as "(1) Wi-Fi"; disabled ones show
    # "(*) Name" and are skipped by the \d+ match. We pick the first that holds a
    # real IPv4 address, which sidesteps VPN tunnels (e.g. ipsec0) being default.
    for svc in (networksetup -listnetworkserviceorder | string match -rg '^\(\d+\)\s+(.+)$')
        set -l ip (networksetup -getinfo "$svc" 2>/dev/null | string match -rg '^IP address:\s+(\S+)$')
        if test -n "$ip" -a "$ip" != none
            echo $svc
            return 0
        end
    end
    return 1
end

function mitm -d "Toggle the macOS system HTTP/HTTPS proxy through mitmproxy"
    set -l port 8080
    # Optional explicit service: `mitm on "Wi-Fi"`, else auto-detect.
    set -l svc $argv[2]
    test -n "$svc"; or set svc (__mitm_service)

    if test -z "$svc"
        echo "mitm: could not find an active network service" >&2
        return 1
    end

    switch "$argv[1]"
        case on
            networksetup -setwebproxy "$svc" 127.0.0.1 $port
            and networksetup -setsecurewebproxy "$svc" 127.0.0.1 $port
            and echo "mitm: proxy ON for \"$svc\" → 127.0.0.1:$port"
        case off
            networksetup -setwebproxystate "$svc" off
            and networksetup -setsecurewebproxystate "$svc" off
            and echo "mitm: proxy OFF for \"$svc\""
        case status ''
            echo "Service: $svc"
            echo "HTTP : "(networksetup -getwebproxy "$svc" | string join ' ')
            echo "HTTPS: "(networksetup -getsecurewebproxy "$svc" | string join ' ')
        case '*'
            echo "Usage: mitm on|off|status [service]  (abbr: mitmon / mitmoff)"
            return 1
    end
end
