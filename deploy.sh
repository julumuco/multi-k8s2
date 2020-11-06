docker build -t jldocker954/multi-client:latest -t jldocker954/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t jldocker954/multi-server:latest -t jldocker954/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jldocker954/multi-worker:latest -t jldocker954/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jldocker954/multi-client:latest
docker push jldocker954/multi-server:latest
docker push jldocker954/multi-worker:latest

docker push jldocker954/multi-client:$SHA
docker push jldocker954/multi-server:$SHA
docker push jldocker954/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jldocker954/multi-server:$SHA
kubectl set image deployments/client-deployment client=jldocker954/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jldocker954/multi-worker:$SHA
