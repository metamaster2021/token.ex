# token.ex

## variant data field example

----
### [amax.token.hpp](./contracts/amax.token/include/amax.token/amax.token.hpp)
#### define variant type `token_info_ex`
```c++
   struct amax_token_info {
      eosio::name bank;
      std::string full_name;

      EOSLIB_SERIALIZE( amax_token_info,  (bank)(full_name)  )
   };

   struct eth_token_info {
      std::string address;
      std::string full_name;
      std::string memo;
      EOSLIB_SERIALIZE( eth_token_info,  (address)(full_name)(memo)  )
   };

   typedef std::variant<amax_token_info, eth_token_info> token_info_ex;
```

#### add variant field `info_ex`
```c++
   struct [[eosio::table]] currency_stats {
      asset    supply;
      asset    max_supply;
      name     issuer;
      token_info_ex     info_ex;

      uint64_t primary_key()const { return supply.symbol.code().raw(); }
   };

```

#### add param `info_ex` to create() action
```c++
[[eosio::action]]
void create( const name&   issuer,
               const asset&  maximum_supply, const token_info_ex& info_ex);
```

----
### [amax.token.cpp](./contracts/amax.token/src/amax.token.cpp)
#### implements in create() action
```c++
void token::create( const name&   issuer,
                    const asset&  maximum_supply, const token_info_ex& info_ex )
{
    require_auth( get_self() );

    check(is_account(issuer), "issuer account does not exist");
    auto sym = maximum_supply.symbol;
    check( sym.is_valid(), "invalid symbol name" );
    check( maximum_supply.is_valid(), "invalid supply");
    check( maximum_supply.amount > 0, "max-supply must be positive");

    stats statstable( get_self(), sym.code().raw() );
    auto existing = statstable.find( sym.code().raw() );
    check( existing == statstable.end(), "token with symbol already exists" );

    statstable.emplace( get_self(), [&]( auto& s ) {
       s.supply.symbol = maximum_supply.symbol;
       s.max_supply    = maximum_supply;
       s.issuer        = issuer;
       s.info_ex       = info_ex;
    });
}
```

### test on testnet
- see [test.sh](./test.sh)
