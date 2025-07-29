from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

class IndexView(APIView):
    def get(self, request):
        return Response({"message": "GET request successful"})

class CreateView(APIView):
    def post(self, request):
        print("Request data:", request.data)
        return Response({"message": "POST request successful", "data": request.data})

class RequestCreditCardView(APIView):
    def post(self, request):
        print("Request data:", request.data)
        return Response({"message": "Credit card request successful", "data": request.data})