abstract class Rectangle
{
	PVector position;
	float size;
	float rectWidth, rectHeight;
	float top, bottom, left, right;
	int collides;
	String name;
	Box box;

	protected String getName() {
		return name;
	}

	protected float getX()
	{
		return position.x;
	}

	protected float getY()
	{
		return position.y;
	}

	protected float getSize() {
		return size;
	}

	protected float getWidth() {
		return rectWidth;
	}

	protected float getHeight() {
		return rectHeight;
	}

	protected float getTop() {
		return top;
	}

	protected float getBottom() {
		return bottom;
	}

	protected float getLeft() {
		return left;
	}

	protected float getRight() {
		return right;
	}
	protected int getCollides() {
		return collides;
	}
	protected Box getBox() {
		return box;
	}
}
