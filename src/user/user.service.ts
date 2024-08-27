import { Injectable } from '@nestjs/common';
import { User, UserRole } from './user.entity';
import * as bcrypt from 'bcryptjs';

@Injectable()
export class UserService {
  private users: User[] = [
    {
      id: 1,
      username: 'admin',
      password: bcrypt.hashSync('admin-pass', 10),
      roles: [UserRole.ADMIN],
    },
    {
      id: 2,
      username: 'user',
      password: bcrypt.hashSync('user-pass', 10),
      roles: [UserRole.USER],
    },
    {
      id: 3,
      username: 'manager',
      password: bcrypt.hashSync('manager-pass', 10),
      roles: [UserRole.MANAGER],
    },
  ];

  async findByUsername(username: string): Promise<User | undefined> {
    return this.users.find((user) => user.username === username);
  }
}
