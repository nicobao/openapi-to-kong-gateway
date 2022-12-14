# Test OpenAPI + Kong

Originally forked from https://github.com/svenwal/kong-user-call-2022-07/

## pre-requisites

- Install docker
- Install inso CLI
- Install deck CLI

For testing purpose:
- curl
- jq

(`.insomnia` directory was copied from https://github.com/Kong/insomnia/tree/develop/packages/insomnia-inso/src/db/fixtures/git-repo )

## start kong (locally)

Run `./start_kong.sh`

Test it's working correctly:

```
nicolas@nicolas-Precision-14-5470:~/others/kong-user-call-2022-07/OpenAPI$ curl --head localhost:8001
HTTP/1.1 200 OK
Date: Wed, 14 Dec 2022 15:42:52 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Access-Control-Allow-Origin: http://localhost:8002
X-Kong-Admin-Request-ID: Nm5li6Lz1oswo4DS0I4D2KSV8GduphOB
vary: Origin
Access-Control-Allow-Credentials: true
Content-Length: 19177
X-Kong-Admin-Latency: 7
Server: kong/3.1.1.1-enterprise-edition
```

## stop kong (locally)

Run `./stop_kong.sh`


## Add petstore endpoints

Run `./from-petstore-openapi-to-kong.sh`

Verify that it has been added by running:
- `curl -s -X GET http://localhost:8001/routes | jq` 
- `curl -s -X GET http://localhost:8001/services | jq`

## Add catstore endpoints

Run `./from-catstore-openapi-to-kong.sh`

Verify that it has been added by running:
- `curl -s -X GET http://localhost:8001/routes | jq` 
- `curl -s -X GET http://localhost:8001/services | jq`

You will see that it has not overriden the petstore endpoints. That's because of the `--select-tags` in `deck sync`. Be careful because without that `sync` will delete all the routes and services that are not in the provided descriptive `.yml` file.

## Some explanations

The process is as follow:
- create an openapi yml document
- validate it's correctly formed
- run tests on it
- transform it into a Kong Descriptive YML document (services and routes objects description). The mapping is described [here](https://www.npmjs.com/package/openapi-2-kong?activeTab=readme) (refresh the page if the readme doesn't pop up). There are some particularities, especially when it comes to auth.
-

## Resources

- https://youtu.be/ektIWuIh_uM
- https://github.com/svenwal/kong-user-call-2022-07

## License

[BSD-2-Clause-Patent](./LICENSE)
