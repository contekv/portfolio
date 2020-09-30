//= require jquery
//= require_tree .

<script type="text/javascript">
		$(function() {
			$('.hamburger').click(function() {
				$(this).toggleClass('active');
		
				if ($(this).hasClass('active')) {
					$('.globalMenuSp').addClass('active');
				} else {
					$('.globalMenuSp').removeClass('active');
				}
			});
		});
	</script>