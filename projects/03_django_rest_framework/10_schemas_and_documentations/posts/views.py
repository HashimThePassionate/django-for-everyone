# posts/views.py
# from rest_framework import generics
from django.contrib.auth import get_user_model
from rest_framework.permissions import IsAdminUser
from rest_framework import viewsets  # new
from .models import Post
from .serializers import PostSerializer, UserSerializer
from .permissions import IsAuthorOrReadOnly
from .throttling import FivePerFiveMinuteThrottle  # Import custom throttle

# class PostList(generics.ListCreateAPIView):
#     permission_classes = (IsAuthorOrReadOnly,)
#     throttle_classes = (FivePerFiveMinuteThrottle,)
#     queryset = Post.objects.all()
#     serializer_class = PostSerializer

# class PostDetail(generics.RetrieveUpdateDestroyAPIView):
#     permission_classes = (IsAuthorOrReadOnly,)
#     # permission_classes = (permissions.IsAdminUser,)
#     queryset = Post.objects.all()
#     serializer_class = PostSerializer


class PostViewSet(viewsets.ModelViewSet):  # new
    permission_classes = (IsAuthorOrReadOnly,)
    throttle_classes = (FivePerFiveMinuteThrottle,)
    queryset = Post.objects.all()
    serializer_class = PostSerializer


class UserViewSet(viewsets.ModelViewSet):  # new
    permission_classes = [IsAdminUser]
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer


# class UserList(generics.ListCreateAPIView):  # new
#     queryset = get_user_model().objects.all()
#     serializer_class = UserSerializer

# class UserDetail(generics.RetrieveUpdateDestroyAPIView):  # new
#     queryset = get_user_model().objects.all()
#     serializer_class = UserSerializer
