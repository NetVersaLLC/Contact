perl -le 'foreach ("aa" .. "zz") { system("./request.sh $_ > cats/$_.js"); system "ls -l cats/$_.js"; sleep 1; }'
