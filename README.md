Apex-JSON-Generator
===================
The contents of this repo are a Visualforce page and it’s corresponding controller and tests.  You essentially paste a json response into the text box, tell the page what base class name you want and click submit.  From there the code iterates over the JSON in a recursive manner generating a mirror of the JSON object structure in Apex.  It will take into account strings, decimals, lists, and custom object types when creating the classes.

The nice thing about this is once the classes are generated, simply copy-paste them wherever you want and it will work with deserialization out of the box.  To deserialize the response using the example above, use this code:

```java
MyClass mc = (MyClass)JSON.deserialize(jsonString, MyClass.class);
```

This assumes the classes were pasted in the same class this line of code resides as well as jsonString is the valid JSON that matches what you generated the classes from.  By doing this, all of the data in the JSON string is now populated into your base class ready for you to do do what you will.

Hopefully this saves you some time.  If you have any questions or suggestions, feel free to let me know.
