from django.urls import path
from store import views
from rest_framework.routers import SimpleRouter
from .views import ProductViewSet, CollectionViewSet
from pprint import pprint
router = SimpleRouter()
router.register('products',ProductViewSet)
router.register('collections',CollectionViewSet)
pprint(router.urls)
urlpatterns = router.urls
# urlpatterns = [
#     # path('products/', views.product_list),
#     path('products/', views.ProductList.as_view()),
#     path('products/<int:pk>/', views.ProductDetail.as_view()),
#     # path('products/<int:id>/', views.product_detail),
#     # path('collections/', views.collection_list),
#     path('collections/', views.CollectionList.as_view()),
#     # path('collection/<int:pk>/', views.collection_detail, name='collection-detail')
#     path('collection/<int:pk>/', views.CollectionDetail.as_view())
# ]
