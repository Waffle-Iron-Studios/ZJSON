class JsonObjectElement {
	String key;
	JsonElement e;
	
	static JsonObjectElement make(String key,JsonElement e){
		JsonObjectElement elem=new("JsonObjectElement");
		elem.key=key;
		elem.e=e;
		return elem;
	}
}

class JsonObjectKeys {
	Array<String> keys;
}

class JsonObject : JsonElement {
	const table_size = 256; // rather small for a general hash table, but should be enough for a json object
	private Array<JsonObjectElement> table[table_size];
	private uint elems;
	
	static JsonObject make(){
		return new("JsonObject");
	}
	
	private uint hash(String s){ // djb2 hashing algorithm
		uint h=5381;
		for(uint i=0;i<s.length();i++){
			h=(h*33)+s.byteat(i);
		}
		return h;
	}
	
	private JsonElement getFrom(out Array<JsonObjectElement> arr,String key){
		for(uint i=0;i<arr.size();i++){
			if(arr[i].key==key){
				return arr[i].e;
			}
		}
		return null;
	}
	
	private bool setAt(out Array<JsonObjectElement> arr,String key,JsonElement e,bool replace){
		for(uint i=0;i<arr.size();i++){
			if(arr[i].key==key){
				if(replace){
					arr[i].e=e;
				}
				return replace;
			}
		}
		arr.push(JsonObjectElement.make(key,e));
		elems++;
		return true;
	}
	
	private bool delAt(out Array<JsonObjectElement> arr,String key){
		for(uint i=0;i<arr.size();i++){
			if(arr[i].key==key){
				arr.delete(i);
				elems--;
				return true;
			}
		}
		return false;
	}
	
	JsonElement get(String key){
		return getFrom(table[hash(key)%table_size],key);
	}
	
	void set(String key,JsonElement e){
		setAt(table[hash(key)%table_size],key,e,true);
	}
	
	bool insert(String key,JsonElement e){//only inserts if key doesn't exist, otherwise fails and returns false
		return setAt(table[hash(key)%table_size],key,e,false);
	}
	
	bool delete(String key){
		return delAt(table[hash(key)%table_size],key);
	}
	
	JsonObjectKeys getKeys(){
		JsonObjectKeys keys = new("JsonObjectKeys");
		for(uint i=0;i<table_size;i++){
			for(uint j=0;j<table[i].size();j++){
				keys.keys.push(table[i][j].key);
			}
		}
		return keys;
	}
	
	bool empty(){
		return elems==0;
	}
	
	void clear(){
		for(uint i=0;i<table_size;i++){
			table[i].clear();
		}
	}
	
	uint size(){
		return elems;
	}
}
