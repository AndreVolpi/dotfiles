# Run only in interactive shells (prevents loops in non-interactive invocations)
status is-interactive; or exit

# Ensure TMPDIR is defined (macOS sometimes misses it in odd contexts)
if not set -q TMPDIR
    set -gx TMPDIR /tmp
end

# If fisher is missing, install it once.
if not functions -q fisher
    if command -q curl
        echo "[fish] Installing fisher…"
        # Use command to avoid function/alias interference; fail quietly if offline.
        command curl -fsSL https://git.io/fisher | source
        fisher install jorgebucaran/fisher
        fisher update
    else
        echo "[fish] curl not found; cannot bootstrap fisher."
        exit
    end
end

