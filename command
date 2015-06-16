
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;
String searchString = "command";
List<Status> tweets;

int currentTweet;
int offsetx, offsety;
PFont f;
PImage img;

void setup()
{
    size(636, 825);
   f = loadFont("HelveticaNeue-Bold-90.vlw");
   
img = loadImage("postprayerbooktemplate.jpg");
 
  

  
    // for twitter
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("dAetfI894W5jXnhfxiwTwQ");
    cb.setOAuthConsumerSecret("tpPsBjUXR3GsbZ2ObJvFILDSdlmmz5ihtgLP1xarRE");
    cb.setOAuthAccessToken("1931562348-NhKsuF8AS403va2cgMoAmfqm7sy1r4K8XTDdJer");
    cb.setOAuthAccessTokenSecret("S56LY34MQxZw3YKBPKNekPaqZk5r4IiFKgJAxr4VqkwTw");

    TwitterFactory tf = new TwitterFactory(cb.build());

    twitter = tf.getInstance();

    getNewTweets();

    currentTweet = 0;

    
}

void draw()
{
 background(255);
   image(img, 0, 0, 637.5, 825);
   textAlign (CENTER, TOP);
     textFont(f, 20);

    currentTweet = currentTweet + 1;

    if (currentTweet >= tweets.size())
    {
      print("getting new tweets");

      currentTweet = 0;
      getNewTweets();
        
    }
  Status status = tweets.get(currentTweet);

    fill(0);
text(status.getText(), 175, 200, 300, 1000);
    
     delay(8000); 
}

void getNewTweets()
{
    try
    {
        Query query = new Query(searchString);

        QueryResult result = twitter.search(query);

        tweets = result.getTweets();
    }
    catch (TwitterException te)
    {
        System.out.println("Failed to search tweets: " + te.getMessage());
        System.exit(-1);
    }
    
    //going to print out new tweets
    int curt = 0;
    for(int i=0; i< tweets.size(); i++){
   
     Status status = tweets.get(curt);
     print(status.getText() + "\n");
     curt = curt + 1;
    }
}

void refreshTweets()
{
    while (true)
    {
        getNewTweets();

        println("Updated Tweets");

        delay(30000);
    }
}
