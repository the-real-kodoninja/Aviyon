export const idlFactory = ({ IDL }) => {
  const Message = IDL.Record({
    'content' : IDL.Text,
    'user' : IDL.Text,
    'timestamp' : IDL.Int,
  });
  return IDL.Service({
    'getMessages' : IDL.Func([], [IDL.Vec(Message)], ['query']),
    'sendMessage' : IDL.Func([IDL.Text, IDL.Text], [], []),
  });
};
export const init = ({ IDL }) => { return []; };
