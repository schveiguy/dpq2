﻿module dpq2.args;

@trusted:

import dpq2;
import vibe.data.bson;
import dpq2.types.from_d_types;

/// Query parameters
struct QueryParams
{
    string sqlCommand; /// SQL command
    QueryArg[] args; /// SQL command arguments
    ValueFormat resultFormat = ValueFormat.BINARY; /// Result value format

    @property void argsFromArray(in string[] arr)
    {
        args.length = arr.length;

        foreach(i, ref a; args)
            a = toValue(arr[i]);
    }

    @property string preparedStatementName() const { return sqlCommand; }
    @property void preparedStatementName(string s){ sqlCommand = s; }
}

alias QueryArg = Value; // TODO: remove it

unittest
{
    immutable s = "test string";

    QueryArg q = toValue(s);

    assert(q.as!string == s);
}

private OidType convType(Bson.Type bt)
{
    switch(bt)
    {
        case Bson.Type.string:
            return OidType.Text;

        default:
            assert(false, "Can't convert Bson type "~bt.to!string~" to Oid type");
    }
}
