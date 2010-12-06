module ApplicationHelper
  def active_item?(controller, action)
    return 'active' if controller == params[:controller] && action == params[:action]
    'inactive'
  end
  
  def google_analytics
    %Q(
    <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{GOOGLE_CONFIG['ga_code']}']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
    </script>
    )
  end

end
