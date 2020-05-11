from userapp.viewsets import studentViewSet
from rest_framework import routers

router = routers.DefaultRouter()
router.register('student',studentViewSet)