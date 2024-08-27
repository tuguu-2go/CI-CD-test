export enum UserRole {
  ADMIN = 'admin',
  USER = 'user',
  MANAGER = 'manager',
}

export class User {
  id: number;
  username: string;
  password: string;
  roles: UserRole[];
}
