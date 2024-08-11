
class XboxSecretExits : LevelPostProcessor
{
    protected void Apply(Name checksum, String mapname)
    {
        if ( CVar.FindCVar("ws_xbox_secret_exits").GetBool() )
        {
            switch (checksum)
            {
                case '3CB5FAE83B470A9ACCD9B9B2102447DF': // Doom E1M1
                {
                    SetLineActivation(272, SPAC_Use);
                    SetLineSpecial(272, Exit_Secret, 0);
                    break;
                }
                case 'B49F7A6C519757D390D52667DB7D8793': // Ultimate Doom E1M1
                {
                    SetLineActivation(268, SPAC_Use);
                    SetLineSpecial(268, Exit_Secret, 0);
                    break;
                }
                case 'AB24AE6E2CB13CBDD04600A4D37F9189': // Doom II MAP01
                {
                    SetLineActivation(283, SPAC_Use);
                    SetLineSpecial(283, Exit_Secret, 0);
                    break;
                }
            }
        }
    }
}
