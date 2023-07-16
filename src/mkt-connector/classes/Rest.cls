public with sharing class Rest {
    public class RestException extends Exception {
        public integer errorcode;
        public string documentation;

        public RestException (Rest.GenericErrorResponse errorBody){
            this(errorBody.message);
            this.errorcode = errorBody.errorcode;
            this.documentation = errorBody.documentation;
        }
	}

    public class GenericErrorResponse {
        public string message;
        public integer errorcode;
        public string documentation;
    }
}