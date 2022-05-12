#!/usr/bin/env bash

# testnet

## test init

# build
export CXXFLAGS=''
rm -rf build
bash build.sh -y

alias amcli='amcli -u http://hk-t1.nchain.me:18888'

# amcli create account amax test4vatiant AM5SuwLEfX8GBFhBYryH98a7dbgpTV8BBPojH2m8wr7yT3hks5iH -p amax@active
amcli system newaccount --transfer amax test4variant AM5SuwLEfX8GBFhBYryH98a7dbgpTV8BBPojH2m8wr7yT3hks5iH \
   --stake-net "0.01000000 AMAX" --stake-cpu "0.01000000 AMAX" --buy-ram-kbytes "300" -p amax@active

amcli system buyram --kbytes amax test4variant 300

amcli set contract test4variant ./build/contracts/amax.token -p test4variant@active

## Create and allocate the SYS currency = AMAX
amcli push action test4variant create '[ "amax", "1000000000.00000000 AMAX", ["amax_token_info", ["amax.token", "8,AMAX"] ] ]' -p test4variant@active
## issue
amcli push action test4variant issue '[ "amax", "500000000.00000000 AMAX", "" ]' -p amax@active

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

## test for 3th variant
export CXXFLAGS='-DBTC_TOKEN'
rm -rf build
bash build.sh -y

amcli system delegatebw amax --transfer test4variant "1.00000000 AMAX" "1.00000000 AMAX"

## upgrade contract
amcli set contract test4variant ./build/contracts/amax.token -p test4variant@active

amcli push action test4variant create '[ "amax", "1000000000.00000000 BTC", ["btc_token_info", ["bc1qqy697l5fg76u08ru7we85jztq62f339xrcyka3", "8,BTC", 100000000] ] ]' -p test4variant@active
# tx: 054435b33737005935b5a4df9a2c37b742403f5d8137280dddf98cd21ff3d11b

## issue
amcli push action test4variant issue '[ "amax", "500000000.00000000 BTC", "" ]' -p amax@active

amcli get table test4variant BTC stat
# result:
{
  "rows": [{
      "supply": "500000000.00000000 BTC",
      "max_supply": "1000000000.00000000 BTC",
      "issuer": "amax",
      "info_ex": [
        "btc_token_info",{
          "address": "bc1qqy697l5fg76u08ru7we85jztq62f339xrcyka3",
          "memo": "8,BTC",
          "amount": 100000000
        }
      ]
    }
  ],
  "more": false,
  "next_key": ""
}
