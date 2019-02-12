docker build -t jji421/multi-client:latest -t jji421/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jji421/multi-server:latest -t jji421/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jji421/multi-worker:latest -t jji421/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jji421/multi-client:latest
docker push jji421/multi-server:latest
docker push jji421/multi-worker:latest
docker push jji421/multi-client:$SHA
docker push jji421/multi-server:$SHA
docker push jji421/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jji421/multi-server:$SHA
kubectl set image deployments/client-deployment client=jji421/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jji421/multi-worker:$SHA