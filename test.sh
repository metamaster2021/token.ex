#!/usr/bin/env bash

# testnet

# system newaccount --transfer amax test4vatiant %s --stake-net "%s" --stake-cpu "%s" --buy-ram "%s


alias amcli='amcli -u http://hk-t1.nchain.me:18888'

# amcli create account amax test4vatiant AM5SuwLEfX8GBFhBYryH98a7dbgpTV8BBPojH2m8wr7yT3hks5iH -p amax@active
amcli system newaccount --transfer amax test4variant AM5SuwLEfX8GBFhBYryH98a7dbgpTV8BBPojH2m8wr7yT3hks5iH \
   --stake-net "0.01000000 AMAX" --stake-cpu "0.01000000 AMAX" --buy-ram-kbytes "300" -p amax@active

amcli system buyram --kbytes amax test4variant 300

amcli set contract test4variant ./build/contracts/amax.token -p test4variant@active

## Create and allocate the SYS currency = AMAX
amcli push action test4variant create '[ "amax", "1000000000.00000000 AMAX", ["amax_token_info", ["amax.token", "8,AMAX"] ] ]' -p test4variant@active
## issue
# amcli push action test4variant issue '[ "amax", "500000000.00000000 AMAX", "" ]' -p test4variant@active

amcli get table test4variant AMAX stat
## result:
{
  "rows": [{
      "supply": "0.00000000 AMAX",
      "max_supply": "1000000000.00000000 AMAX",
      "issuer": "amax",
      "info_ex": [
        "amax_token_info",{
          "bank": "amax.token",
          "full_name": "8,AMAX"
        }
      ]
    }
  ],
  "more": false,
  "next_key": ""
}

