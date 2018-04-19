<!-- 커뮤니티 목록 -->
<% @communities.each do |comu| %>
  커뮤니티 제목: <%= comu.title %>
  커뮤니티 내용: <%= comu.content %>
  커뮤니티 개설자: <%= @dict_co[comu.user_id].name %>
  커뮤니티 이미지: <img src="<%= comu.image.url%>">
  커뮤니티 하트수: <%= comu.heart %>
  <!-- 커뮤니티 하트 누르기 -->
  <% if current_vuser != nil and @heart_comu[comu.id] == nil %> 
  <div class="chart_button"  onclick="chearton( <%= comu.id %> );" id="comu<%= comu.id %>" >
	 <%= link_to 'Heart 누르기', cheart_path( :id => comu.id ), method: :post, remote: true%>
  </div>
  <% elsif current_vuser != nil %>
   <div class="chart_button"  onclick="cheartoff( <%= comu.id %> );" id="comu<%= comu.id %>" >
      <%= link_to 'Heart 끄기', cheart_path( :id => comu.id ), method: :post, remote: true%>
   </div>
  <% else %>
      하트를 누르려면 로그인!
  <% end %>
<% end %>
<script>
       function chearton(cid){
		   document.getElementById('comu'+ cid).innerHTML = "<%= link_to 'Heart 끄기', cheart_path( :id => " + <%= comu.id.to_s %>+" ), method: :post, remote: true%>"
	   }
		function cheartoff(cid){
          document.getElementById('comu'+ cid).innerHTML = "<%= link_to 'Heart 켜기', cheart_path( :id => " + <%= comu.id.to_s %>+" ), method: :post, remote: true%>"
	   }
</script>


