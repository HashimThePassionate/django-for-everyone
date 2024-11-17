# posts/views.py
from rest_framework import generics, permissions
from .models import Post
from .serializers import PostSerializer
from .permissions import IsAuthorOrReadOnly   
from .throttling import FivePerFiveMinuteThrottle  # Import custom throttle

class PostList(generics.ListCreateAPIView):
    permission_classes = (IsAuthorOrReadOnly,) 
    throttle_classes = (FivePerFiveMinuteThrottle,)
    queryset = Post.objects.all()
    serializer_class = PostSerializer

class PostDetail(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthorOrReadOnly,) 
    # permission_classes = (permissions.IsAdminUser,) 
    queryset = Post.objects.all()
    serializer_class = PostSerializer
