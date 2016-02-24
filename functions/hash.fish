function hash -d "Compute and print a hash digest" -a algorithm string
  # User needs some help.
  if begin; not set -q argv[1]; or contains -- -h $argv; or contains -- --help $argv; end
    echo "Compute and print a hash digest.

Usage:
  hash <algorithm> [<string>]
  hash -q <algorithm>
"
    return
  end

  # User simply wants to check if an algorithm is available.
  if test $algorithm = -q
    __hash_gnu_available $string
      or __hash_bsd_available $string
      or __hash_openssl_available $string
    return
  end

  # Determine which utility to use for the given algorithm, then execute it.
  if __hash_gnu_available $algorithm
    __hash_gnu $algorithm "$string"
  else if __hash_bsd_available $algorithm
    __hash_gnu $algorithm "$string"
  else if __hash_openssl_available $algorithm
    __hash_openssl $algorithm "$string"
  else
    echo "No implementation found for algorithm '$algorithm'." >&2
    return 1
  end
end

function __hash_gnu_available -a algorithm
  type -q -- {"$algorithm"}sum
end

function __hash_gnu -a algorithm string
  test -n $string
    and echo $string | eval {"$algorithm"}sum | cut -d ' ' -f 1
    or eval {"$algorithm"}sum | cut -d ' ' -f 1
end

function __hash_bsd_available -a algorithm
  type -q -- $algorithm
end

function __hash_bsd -a algorithm string
  test -n $string
    and eval $algorithm -q -s "'$string'"
    or eval $algorithm -q
end

function __hash_openssl_available -a algorithm
  type -q -- openssl
    and openssl list-message-digest-algorithms | grep -i -x -- $algorithm > /dev/null
end

function __hash_openssl -a algorithm string
  test -n $string
    and echo $string | openssl dgst -$algorithm -r | cut -d ' ' -f 1
    or openssl dgst -$algorithm -r | cut -d ' ' -f 1
end
