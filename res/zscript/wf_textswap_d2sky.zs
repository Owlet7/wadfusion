//------------------------------------------------------------------------------------------
//
// The MIT License (MIT)
// 
// Copyright (c) 2016-2023 JP LeBreton
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//------------------------------------------------------------------------------------------
//

extend class WadFusionHandler
{
	// check if the given sky is the level's current sky, see if that is
	// being overriden, and if so change it. return whether this happened.
	bool checkSkyOverriden(string skyName, string possibleTrueSkyName)
	{
		string sky1Name = TexMan.GetName(Level.SkyTexture1);
		if ( skyName != sky1Name )
			return false;
		int flags = TexMan.ReturnFirst; // default = TexMan.TryAny
		TextureID skyA = TexMan.CheckForTexture(possibleTrueSkyName, TexMan.Type_Any, flags);
		TextureID skyB = TexMan.CheckForTexture(possibleTrueSkyName, TexMan.Type_Override, flags);
		if ( skyA == skyB )
			return false;
		// use skyA as sky2 if it's the same as sky1, otherwise don't touch it
		TextureID skyA2 = (Level.SkyTexture1 == Level.SkyTexture2) ? skyA : Level.SkyTexture2;
		Level.ChangeSky(skyA, skyA2);
		return true;
	}
	
	void DoDoom2SkyReplacements()
	{
		if ( checkSkyOverriden("RSKY1", "SKY1") )
			return;
		else if ( checkSkyOverriden("RSKY2", "SKY2") )
			return;
		checkSkyOverriden("RSKY3", "SKY3");
	}
}
