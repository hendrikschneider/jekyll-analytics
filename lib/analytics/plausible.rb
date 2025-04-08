class Plausible
    def initialize(config)
        @domain = config['domain']
        @source = config['source']
        @host = config['host']
        @not_found = !!config['404_tracking']
        @embed = !!config['embed_tracker']
    end

    def render()
        if @embed
            return "<script defer async>#{<<~SCRIPT.strip}</script>"
            !function(r,i){"use strict";var e,o=r.location,s=r.document,l="#{@domain}",p=r.localStorage.plausible_ignore;function c(e){console.warn("Ignoring Event: "+e)}function a(e,t){if(/^localhost$|^127(?:\.[0-9]+){0,2}\.[0-9]+$|^(?:0*\:)*?:?0*1$/.test(o.hostname)||"file:"===o.protocol)return c("localhost");if(!(r.phantom||r._phantom||r.__nightmare||r.navigator.webdriver||r.Cypress)){if("true"==p)return c("localStorage flag");var a={};a.n=e,a.u=o.href,a.d=l,a.r=s.referrer||null,a.w=r.innerWidth,t&&t.meta&&(a.m=JSON.stringify(t.meta)),t&&t.props&&(a.p=JSON.stringify(t.props));var n=new XMLHttpRequest;n.open("POST",i+"/api/event",!0),n.setRequestHeader("Content-Type","text/plain"),n.send(JSON.stringify(a)),n.onreadystatechange=function(){4==n.readyState&&t&&t.callback&&t.callback()}}}function n(){e!==o.pathname&&(e=o.pathname,a("pageview"))}try{var u,h=r.history;h.pushState&&(u=h.pushState,h.pushState=function(){u.apply(this,arguments),n()},r.addEventListener("popstate",n));var g=r.plausible&&r.plausible.q||[];r.plausible=a;for(var f=0;f<g.length;f++)a.apply(this,g[f]);"prerender"===s.visibilityState?s.addEventListener("visibilitychange",function(){e||"visible"!==s.visibilityState||n()}):n()}catch(e){console.error(e),(new Image).src=i+"/api/error?message="+encodeURIComponent(e.message)}}(window,"#{@host}");
            SCRIPT
        else
            tag = "<script async defer data-domain=\"#{@domain}\" src=\"#{@source}\"></script>"
            if @not_found
                tag += "<script>window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments) }</script>"
            end
            return tag
        end
    end
end
