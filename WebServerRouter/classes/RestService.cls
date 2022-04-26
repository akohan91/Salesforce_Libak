/**
 * @author Andrew Kohanovskij <akohan91@gmail.com>
 */
@RestResource(urlMapping = '/*')
global with sharing class RestService {

	@HttpGet
	global static void handleGet() {
		handleRequest();
	}
	@HttpPost
	global static void handlePost() {
		handleRequest();
	}
	@HttpPut
	global static void handlePut() {
		handleRequest();
	}
	@HttpPatch
	global static void handlePatch() {
		handleRequest();
	}
	@HttpDelete
	global static void handleDelete() {
		handleRequest();
	}

	private static void handleRequest() {
		try {
			AbstractRestProcessor.getInstance(RestContext.request).process();
		} catch (Exception exc) {
			new ResponseJSON(exc).sendServerErrorResponse();
		}
	}
}