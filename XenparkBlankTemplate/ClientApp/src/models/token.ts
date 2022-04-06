export interface Token {
  access_token?: string;
  //token?: string;
  token_type?: string;
  expires_in?: number;
  ResponseCode?: number;
}

export interface LoginInfo {
  userName: string;
  password: string;
}