import { Controller, Get, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from './auth/jwt-auth.guard';
import { Roles } from './auth/roles.decorator';
import { RolesGuard } from './auth/roles.guard';
import { UserRole } from './user/user.entity';

@Controller('app')
export class AppController {
  @Get('admin')
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.ADMIN)
  getAdminContent() {
    return 'This is a restricted area for ADMINs only!';
  }

  @Get('manager')
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.USER, UserRole.MANAGER)
  getManagerContent() {
    return 'This is a restricted area for MANAGERs only!';
  }

  @Get('user')
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.MANAGER, UserRole.ADMIN)
  getUserContent() {
    return 'This is a restricted area for USERS, MANAGERS, and ADMINs!';
  }
}
