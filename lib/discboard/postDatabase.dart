import 'package:firebase_database/firebase_database.dart';
import 'post.dart';

final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts/').push();
  id.set(post.toJson());
  return id;
}

void updatePost(Post posts, DatabaseReference id) {
  id.update(posts.toJson());
}

Future<List<Post>> getAllPosts() async {
  DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
  List<Post> posts = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Post post = createPosts(value);
      post.setId(databaseReference.child('posts/' + key));
      posts.add(post);
    });
  }
  return posts;
}

DatabaseReference saveComment(String postid, Comment comment) {
  var id =
      databaseReference.child('posts/').child(postid).child('comments/').push();
  id.set(comment.toJson());
  return id;
}

void updateComment(Comment comments, DatabaseReference id) {
  id.update(comments.toJson());
}

Future<List<Comment>> getAllComments(String postid) async {
  DataSnapshot dataSnapshot = await databaseReference
      .child('posts/')
      .child(postid)
      .child('comments/')
      .once();
  List<Comment> comments = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Comment comment = createComments(value);
      comment.setId(databaseReference
          .child('posts/')
          .child(postid)
          .child('comments/' + key));
      comments.add(comment);
    });
  }
  return comments;
}
