@isTest
private class MyJSONController_TEST {
    static testMethod void myUnitTest() {
    	Test.startTest();
    	MyJSONController c = new MyJSONController();
    	c.className = 'Test Class Name';
    	c.jsonText = '[{"name":"Java 6 Greatest Hits","Author":"Jim Bob Jones","price":10.25},{"name":"How to raise a goat","Author":"Sir Paxton","price":55.97},{"name":"Snow - It is cold","Author":"Dr. White","price":9.99}]';
    	c.processJSON();
    	c.jsonText = '{[{"name":"Java 6 Greatest Hits","Author":"Jim Bob Jones","price":10.25},{"name":"How to raise a goat","Author":"Sir Paxton","price":55.97},{"name":"Snow - It is cold","Author":"Dr. White","price":9.99}]}';
    	c.processJSON();
    	c.jsonText = '[{"name":"Java 6 Greatest Hits","Author":["Jim Bob Jones","somethingelse"],"price":10.25}';
    	c.processJSON();
		Test.stopTest();    	
    }
}
