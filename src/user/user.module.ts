import { Module } from '@nestjs/common';
import { UserService } from './user.service';

@Module({
  providers: [UserService],
  exports: [UserService], // Export the UserService so it can be used in other modules
})
export class UserModule {}
