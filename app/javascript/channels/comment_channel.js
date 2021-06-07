import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {

    const commentInput = document.getElementById('comment-input');
    commentInput.value='';

    const comment = document.getElementById('new-comment')
    comment.style.setProperty('padding', '15px');
    comment.style.setProperty('width', '50%');
    comment.style.setProperty('margin', '15px auto');
    comment.style.setProperty('display', 'flex');
    comment.style.setProperty('flex-wrap', 'wrap');
    comment.style.setProperty('justify-content', 'space-between');

    const commentText = document.getElementById('new-comment-text');
    commentText.style.setProperty('font-size', '20px');
    commentText.style.setProperty('width', '65%');
    commentText.style.setProperty('text-align', 'left');
    commentText.style.setProperty('word-break', 'break-all');

    const commentInfo = document.getElementById('new-comment-info');
    commentInfo.style.setProperty('font-size', '12px');

    const commentName = document.getElementById('new-comment-name');
    commentName.style.setProperty('text-align', 'left');

    const commentDate = document.getElementById('new-comment-date');
    commentDate.style.setProperty('text-align', 'left');
    var now = new Date();
    var y = now.getFullYear();
    var m = now.getMonth() + 1;
    var d = now.getDate();
    var h = now.getHours();
    var mi = now.getMinutes();

    if (m < 10) {
      m = '0' + m;
    }
    if (d < 10) {
      d = '0' + d;
    }
    if (h < 10) {
      h = '0' + h;
    }
    if (mi < 10) {
      mi = '0' + mi;
    }

    if(gon.seller == true){
      comment.style.setProperty("border", "1px solid skyblue");
      commentInfo.style.setProperty("color", "skyblue")
    }
    else{
      comment.style.setProperty("border", "1px solid black");
      commentInfo.style.setProperty('opacity', '50%');
    }

    commentName.innerHTML = `from ${gon.current_user}(あなた)`;
    commentText.innerHTML = `${data.content.comment}`;
    commentDate.innerHTML = `${y}年${m}月${d}日 ${h}時${mi}分`;

    // commentDate.innerHTML = `${data.content.created_at.strftime("%m月%d日 %H時%M分")}`;

    const comments = document.getElementById('comments');
    const html = `<div id="new-comment">
                    <p id="new-comment-text"></p>
                    <div id="new-comment-info">
                      <p id="new-comment-name"></p>
                      <p id="new-comment-date"></p>
                    </div>
                  </div>`;
    comments.insertAdjacentHTML('afterbegin', html);
  }


});
