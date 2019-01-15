class Debug
{
	StringList texts;
	StringList logs;
	ArrayList<Float> floatValues;
	ArrayList<Boolean> booleanValues;

	PVector textStartPos;
	float textLineOffset;
	float valueOffset;

	Debug()
	{
		texts = new StringList();
		logs = new StringList();
		floatValues = new ArrayList<Float>();
		booleanValues = new ArrayList<Boolean>();

		textStartPos = new PVector(35, 250);
		textLineOffset = 22f;
		valueOffset = 100f;
	}

	void log(String text, boolean value)
	{
		String log;
		log = text + str(value);

		if(!texts.hasValue(text))
		{
			texts.append(text);
			logs.append(log);
		}
		else
		{
			for(int i = 0; i < texts.size(); i++)
			{
				if(texts.get(i) == text)
				{
					logs.set(i, log);
				}
			}
		}
	}

	void log(String text, float value)
	{
		String log;
		log = text + str(value);

		if(!texts.hasValue(text))
		{
			texts.append(text);
			logs.append(log);
		}
		else
		{
			for(int i = 0; i < texts.size(); i++)
			{
				if(texts.get(i) == text)
				{
					logs.set(i, log);
				}
			}
		}
	}

	void drawDebug()
	{
		pushMatrix();
		translate(textStartPos.x, textStartPos.y);
		textAlign(LEFT);

		for(int i = 0; i < logs.size(); i++)
		{
			text(logs.get(i), 0, textLineOffset * i);
		}

		textAlign(CENTER);
		popMatrix();
	}
}
