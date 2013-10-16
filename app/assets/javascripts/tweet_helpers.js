(function($){

    var TweetHelper = {

        formatTweet: function(text) {
            text = TweetHelper.linkURLs(text);
            text = TweetHelper.linkHashes(text);
            text = TweetHelper.linkMentions(text);
            return text;
        },

        linkHashes: function(text) {
            var hash, hashes, url, _i, _len;
            hashes = text.match(/\#[\w]*/gi);
            if (hashes != null) {
                for (_i = 0, _len = hashes.length; _i < _len; _i++) {
                    hash = hashes[_i];
                    url = '<a href="?tweet_query=' + hash.replace("#", "") + '">' + hash + '</a>';
                    text = text.replace(hash, url);
                }
            }
            return text;
        },

        linkMentions: function(text) {
            var mention, mentions, url, username, _i, _len;
            mentions = text.match(/@[\w]*/gi);
            if (mentions != null) {
                for (_i = 0, _len = mentions.length; _i < _len; _i++) {
                    mention = mentions[_i];
                    username = mention.replace("@", "");
                    url = '<a href="/profiles?user_name=' + username + '">@' + username + '</a>';
                    text = text.replace(mention, url);
                }
            }
            return text;
        },

        linkURLs: function(text) {
            var url, urls, _i, _len;
            urls = text.match(/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gi);
            if (urls != null) {
                for (_i = 0, _len = urls.length; _i < _len; _i++) {
                    url = urls[_i];
                    text = text.replace(url, '<a href="' + url + '">' + url + '</a>');
                }
            }
            return text;
        },

        timeAgo: function(dateString){
            var rightNow = new Date();
            var then = new Date(dateString); 
            var diff = rightNow - then;
 
            var second = 1000,
              minute = second * 60,
              hour = minute * 60,
              day = hour * 24,
              week = day * 7;
 
            if (isNaN(diff) || diff < 0) {
                return "";
            }
 
            if (diff < second * 2) return "right now";
            if (diff < minute) return Math.floor(diff / second) + " seconds ago";      
            if (diff < minute * 2) return "about 1 minute ago";
            if (diff < hour) return Math.floor(diff / minute) + " minutes ago";
            if (diff < hour * 2) return "about 1 hour ago";
            if (diff < day) return  Math.floor(diff / hour) + " hours ago";
            if (diff > day && diff < day * 2) return "yesterday";
            if (diff < day * 365) return Math.floor(diff / day) + " days ago";
            else return "over a year ago";
        }
    };

    tweetHelper = TweetHelper;
}(jQuery));