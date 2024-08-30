import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { UserController } from './user/user.controller';
import { AdminController } from './admin/admin.controller';
import { ManagerController } from './manager/manager.controller';

@Module({
  imports: [
    PassportModule,
    JwtModule.register({
      secret: 'secretKey',
      signOptions: { expiresIn: '60s' },
    }),
    UserModule,
    AuthModule,
  ],
  controllers: [
    AppController,
    UserController,
    AdminController,
    ManagerController,
  ],
  providers: [],
})
export class AppModule {}
