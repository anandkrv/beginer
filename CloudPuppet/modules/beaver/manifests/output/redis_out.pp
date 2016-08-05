class beaver::input::redis_out {
        create_resources('beaver::input::redis',hiera('redis_out'))     
}
