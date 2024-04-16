rails new quote-editor --skip-test --database=postgresql --css=sass --skip-jbuilder --skip-action-mailbox --skip-active-storage --skip-action-text

https://dev.to/wizardhealth/install-ruby-320-with-yjit-3mmo
https://engineering.binti.com/jemalloc-with-ruby-and-docker/
https://medium.com/motive-eng/we-solved-our-rails-memory-leaks-with-jemalloc-5c3711326456
https://railsatscale.com/2023-11-07-yjit-is-the-most-memory-efficient-ruby-jit/
https://shopify.engineering/yjit-just-in-time-compiler-cruby
https://railsatscale.com/2023-12-04-ruby-3-3-s-yjit-faster-while-using-less-memory/
https://speed.yjit.org/memory_timeline.html#railsbench
https://github.com/Shopify/yjit
https://gist.github.com/jjb/9ff0d3f622c8bbe904fe7a82e35152fc

ENV LD_PRELOAD=/usr/lib/libjemalloc.so.2 \
    MALLOC_CONF="narenas:2,background_thread:true,thp:never,dirty_decay_ms:1000,muzzy_decay_ms:0" \
    RUBY_YJIT_ENABLE=1

https://acavalin.com/p/rvm_install_ruby_with_jemalloc_yjit
https://github.com/docker-library/ruby/issues/182#issuecomment-1333871598
https://github.com/docker-library/ruby/issues/182#issuecomment-1368432448
https://gist.github.com/jjb/9ff0d3f622c8bbe904fe7a82e35152fc?permalink_comment_id=4789978#gistcomment-4789978


ruby -e "p RbConfig::CONFIG['MAINLIBS']" -v
ldd `which ruby` | grep jemalloc
ruby -e "p ENV['LD_PRELOAD']"
MALLOC_CONF=stats_print:true ruby -e "exit"
<!-- MALLOC_CONF=stats_print:true jemalloc.sh ruby -e "exit" -->
apk info | grep jemalloc
stat -c "%a %n" *
