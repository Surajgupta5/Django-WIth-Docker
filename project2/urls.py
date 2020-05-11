from django.conf.urls import url, include
from django.contrib import admin
from router import router

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    #url(r'^api/', include('rest_framework.urls', namespace='rest_framework'))
    url('api/', include(router.urls))
]
