function docker -w docker
    switch $argv[1]
        case exit
            pkill Docker
        case prune
            _docker_start
            command docker system prune --volumes -fa
        case '*'
            _docker_start
            command docker $argv
    end
end

function _docker_start
    test (uname) = Darwin; or return
    # Check Docker readiness directly instead of pgrep'ing a specific helper
    # process (Docker Desktop dropped com.docker.hyperkit for the VZ backend, so
    # the old `pgrep com.docker.hyperkit` was almost always empty).
    if not command docker stats --no-stream >/dev/null 2>&1
        open -g -j -a Docker.app
        while not command docker stats --no-stream >/dev/null 2>&1
            echo -n .
            sleep 1
        end
        echo
    end
end
