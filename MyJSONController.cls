public with sharing class MyJSONController {
	public String jsonText {get;set;}
	public String className {get;set;}
	public String classesText {get;set;}
	
	public MyJSONController(){
		
	}
	
	public PageReference processJSON(){
		Map<String, Object> myJSONMap = new Map<String, Object>();		
		List<Object> myJSONList = new List<Object>();	
		try{
			myJSONList = (List<Object>)JSON.deserializeUntyped(this.jsonText);
		}catch(Exception e){
			try{
				myJSONMap = (Map<String, Object>)JSON.deserializeUntyped(this.jsonText);
			}catch(Exception ex){
    			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Enter valid JSON text!!!  ' + ex));
			}
		}
		
		if(!myJSONList.isEmpty()){
			myJSONMap = (Map<String, Object>)myJSONList[0];
		}
		
		List<ClassStructure> classes = new List<ClassStructure>();
		classes = buildFromMap(myJSONMap, this.className, new List<ClassStructure>());
		this.classesText = writeOutClasses(classes);
		
		return null;
	}
	
	public List<ClassStructure> buildFromMap(Map<String, Object> myMap, String className, List<ClassStructure> classStructureList){
		ClassStructure myClass = new ClassStructure();
		myClass.className = className;
		
		for(String str : myMap.keySet()){
			ClassProperty cp = new ClassProperty();
			cp.theName = str;
			cp.theType = (isDecimal(myMap.get(str)))?'Decimal':'String';
			System.debug('myMap.get(str):  ' + myMap.get(str));

			try{
				List<Object> newList = (List<Object>)myMap.get(str);
				cp.theType = (newList == null)?cp.theType:'List&#60;String&#62;';
				
				
				Map<String, Object> newMap = (Map<String, Object>)newList[0];
				String tempString = (str.endsWith('s'))?str.substring(0, str.length() - 1):str;
				tempString = tempString.capitalize();
				cp.theType = 'List&#60;' + tempString + '&#62;';
				
				classStructureList = buildFromMap(newMap, tempString, classStructureList);
			}catch(Exception e){
				System.debug('e:  ' + e);
			}
			myClass.properties.add(cp);
		}

		classStructureList.add(myClass);
		return classStructureList;
	}
	
	public String writeOutClasses(List<ClassStructure> classStructureList){
		String s = '';
		for(Integer i = (classStructureList.size() - 1); i >= 0; i--){
			s += '&nbsp;&nbsp;&nbsp;&nbsp;public class ' + classStructureList[i].className + '{<br/>';
			for(ClassProperty cp : classStructureList[i].properties){
				s += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;public ' + cp.theType + ' ' + cp.theName + ' {get;set;}<br/>';
			}
			s += '&nbsp;&nbsp;&nbsp;&nbsp;}<br/><br/>';
		}
		
		return s;	
	}
	
	public static Boolean isDecimal(Object myObject){
		try{
			Decimal d = (Decimal)myObject;
			return true;
		}catch(Exception e){
			return false;
		}
	}
	
	public class ClassStructure{
		public String className = '';
		public List<ClassProperty> properties = new List<ClassProperty>();
	}
	
	public class ClassProperty{
		public String theType = '';
		public String theName = '';	
	}	
}
