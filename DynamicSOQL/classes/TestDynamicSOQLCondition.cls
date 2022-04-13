/**
 * @author Andrew Kohanovskij <akohan91@gmail.com>
 */
@IsTest
public with sharing class TestDynamicSOQLCondition {
	@IsTest
	static void testConstructorValueAsObject(){
		Test.startTest();
		DynamicSOQLCondition condition = new DynamicSOQLCondition('Name', '=', false);
		System.assertEquals(
			'Name', condition.fieldName,
			'The fieldName property is wrong.'
		);
		System.assertEquals(
			'=', condition.operator,
			'The operator property is wrong.'
		);
		System.assertEquals(
			'false', condition.value,
			'The value property is wrong.'
		);
		System.assertEquals(
			null, condition.isString,
			'The isString property is wrong.'
		);
		Test.stopTest();
	}

	@IsTest
	static void testConstructorValueAsDateTime(){
		Test.startTest();
		DynamicSOQLCondition condition = new DynamicSOQLCondition('Name', '=', Datetime.newInstance(2022, 01, 01, 01, 01, 01));
		System.assertEquals(
			'Name', condition.fieldName,
			'The fieldName property is wrong.'
		);
		System.assertEquals(
			'=', condition.operator,
			'The operator property is wrong.'
		);
		System.assertEquals(
			Datetime.newInstance(2022, 01, 01, 01, 01, 01).formatGmt('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''), condition.value,
			'The value property is wrong.'
		);
		System.assertEquals(
			null, condition.isString,
			'The isString property is wrong.'
		);
		Test.stopTest();
	}

	@IsTest
	static void testConstructorValueAsDate(){
		Test.startTest();
		DynamicSOQLCondition condition = new DynamicSOQLCondition('Name', '=', Date.newInstance(2022, 01, 01));
		System.assertEquals(
			'Name', condition.fieldName,
			'The fieldName property is wrong.'
		);
		System.assertEquals(
			'=', condition.operator,
			'The operator property is wrong.'
		);
		System.assertEquals(
			((Datetime)Date.newInstance(2022, 01, 01)).formatGmt('yyyy-MM-dd'), condition.value,
			'The value property is wrong.'
		);
		System.assertEquals(
			null, condition.isString,
			'The isString property is wrong.'
		);
		Test.stopTest();
	}

	@IsTest
	static void testConstructorValueAsString(){
		Test.startTest();
		DynamicSOQLCondition condition = new DynamicSOQLCondition('Name', '=', 'It\'s a string');
		System.assertEquals(
			'Name', condition.fieldName,
			'The fieldName property is wrong.'
		);
		System.assertEquals(
			'=', condition.operator,
			'The operator property is wrong.'
		);
		System.assertEquals(
			'It\\\'s a string', condition.value,
			'The value property is wrong.'
		);
		System.assertEquals(
			true, condition.isString,
			'The isString property is wrong.'
		);
		Test.stopTest();
	}

	@IsTest
	static void testConstructorValueAsStringVariable(){
		Test.startTest();
		DynamicSOQLCondition condition = new DynamicSOQLCondition('Name', '=:', 'variableName');
		System.assertEquals(
			'Name', condition.fieldName,
			'The fieldName property is wrong.'
		);
		System.assertEquals(
			'=:', condition.operator,
			'The operator property is wrong.'
		);
		System.assertEquals(
			'variableName', condition.value,
			'The value property is wrong.'
		);
		System.assertEquals(
			false, condition.isString,
			'The isString property is wrong.'
		);
		System.assertEquals(
			'Name =: variableName', condition.toString(),
			'The "toString()" method returns wrong value.'
		);
		Test.stopTest();
	}

	@IsTest
	static void testConstructorValueAsNull(){
		Test.startTest();
		DynamicSOQLCondition condition = new DynamicSOQLCondition('Name', '=', (String)null);
		System.assertEquals(
			'Name = null', condition.toString(),
			'The "toString()" method returns wrong value.'
		);
		Test.stopTest();
	}

	@IsTest
	static void testfieldApiname(){
		Test.startTest();
		System.assertEquals(
			'Name', new DynamicSOQLCondition('Name', '=', 'Test').fieldApiname(),
			'The "fieldApiname()" method returns wrong value.'
		);
		Test.stopTest();
	}

	@IsTest
	static void testToString(){
		Test.startTest();
		String conditionStr = new DynamicSOQLCondition('Name', '=', 'It\'s a string').toString();
		System.assertEquals(
			'Name = \'It\\\'s a string\'', conditionStr,
			'The "toString()" method returns wrong value.'
		);
		Test.stopTest();
	}

	@IsTest
	static void testToStringWrongOperator(){
		Test.startTest();
		Integer errorCount = 0;
		try {
			new DynamicSOQLCondition('Name', 'wrong', 'It\'s a string').toString();
		} catch (Exception exc) {
			errorCount++;
		}
		System.assertEquals(
			1, errorCount,
			'The error was not occurred.'
		);
		Test.stopTest();
	}
}