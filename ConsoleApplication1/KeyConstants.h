#ifndef KEYCONSTANTS_H
#define KEYCONSTANTS_H

#include <map>
#include <string>

class KeyPair
{
	public:
		KeyPair (const std::string &vk = "", const  std::string &name = "") : VKName (vk), Name (name){}
		std::string VKName;
		std::string Name;


};

class Keys
{
	public:
		static std::map<int, KeyPair> KEYS;

};



#endif // !KEYCONSTANTS_H
